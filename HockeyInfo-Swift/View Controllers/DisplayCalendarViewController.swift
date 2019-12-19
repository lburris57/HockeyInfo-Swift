//
//  DisplayCalendarViewController.swift
//  Hockey Info
//
//  Created by Larry Burris on 12/9/18.
//  Copyright © 2018 Larry Burris. All rights reserved.
//
import JTAppleCalendar
import RealmSwift

final class DisplayCalendarViewController: UIViewController
{
    // MARK: Outlets
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showTodayButton: UIBarButtonItem!
    
    @IBOutlet weak var separatorViewTopConstraint: NSLayoutConstraint!
    
    let databaseManager = DatabaseManager()
    
    var scheduledGames = [NHLSchedule]()
    
    var schedules = [Schedule]()
    
    // MARK: Config
    let formatter = DateFormatter()
    let dateFormatterString = "yyyy MM dd"
    let numOfRowsInCalendar = 6
    let numOfRandomEvent = 100
    let calendarCellIdentifier = "CellView"
    let scheduleCellIdentifier = "detail"
    
    var iii: Date?
    
    // MARK: Helpers
    var numOfRowIsSix: Bool
    {
        get
        {
            return calendarView.visibleDates().outdates.count < 7
        }
    }
    
    var currentMonthSymbol: String
    {
        get
        {
            let startDate = (calendarView.visibleDates().monthDates.first?.date)!
            let month = Calendar.current.dateComponents([.month], from: startDate).month!
            let monthString = DateFormatter().monthSymbols[month-1]
            
            return monthString
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        setupViewNibs()
        showTodayButton.target = self
        showTodayButton.action = #selector(showTodayWithAnimate)
        showToday(animate: false)
        
        let gesturer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        calendarView.addGestureRecognizer(gesturer)
    }
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer)
    {
        let point = gesture.location(in: calendarView)
        
        guard let cellStatus = calendarView.cellStatus(at: point) else
        {
            return
        }
        
        if calendarView.selectedDates.first != cellStatus.date
        {
            calendarView.deselectAllDates()
            calendarView.selectDates([cellStatus.date])
        }
    }
    
    func setupViewNibs()
    {
        let myNib = UINib(nibName: "CellView", bundle: Bundle.main)
        calendarView.register(myNib, forCellWithReuseIdentifier: calendarCellIdentifier)
        
        
        let myNib2 = UINib(nibName: "ScheduleTableViewCell", bundle: Bundle.main)
        tableView.register(myNib2, forCellReuseIdentifier: scheduleCellIdentifier)
    }

    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo)
    {
        guard let startDate = visibleDates.monthDates.first?.date else
        {
            return
        }
        
        let year = Calendar.current.component(.year, from: startDate)
        
        title = "\(currentMonthSymbol) \(year)"
    }
}

// MARK: Helpers
extension DisplayCalendarViewController
{
    func select(onVisibleDates visibleDates: DateSegmentInfo)
    {
        guard let firstDateInMonth = visibleDates.monthDates.first?.date else
        { return }
        
        if firstDateInMonth.isThisMonth()
        {
            calendarView.selectDates([Date()])
        }
        else
        {
            calendarView.selectDates([firstDateInMonth])
        }
    }
}

// MARK: Button events
extension DisplayCalendarViewController
{
    @objc func showTodayWithAnimate()
    {
        calendarView.deselectAllDates()
        
        showToday(animate: true)
    }
    
    func showToday(animate:Bool)
    {
        calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: animate, preferredScrollPosition: nil, extraAddedOffset: 0)
        {
            [unowned self] in
            self.getSchedule()
            self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
        }
            
            self.adjustCalendarViewHeight()
            self.calendarView.selectDates([Date()])
        }
    }
}

// MARK: Dynamic CalendarView's height
extension DisplayCalendarViewController
{
    func adjustCalendarViewHeight()
    {
        adjustCalendarViewHeight(higher: self.numOfRowIsSix)
    }
    
    func adjustCalendarViewHeight(higher: Bool)
    {
        separatorViewTopConstraint.constant = higher ? 0 : -calendarView.frame.height / CGFloat(numOfRowsInCalendar)
    }
}

// MARK: Prepare dataSource
extension DisplayCalendarViewController
{
    func getSchedule()
    {}
}

// MARK: CalendarCell's ui config
extension DisplayCalendarViewController
{
    func configureCell(view: JTAppleCell?, cellState: CellState)
    {
        guard let myCustomCell = view as? CellView else { return }
        
        myCustomCell.dayLabel.text = cellState.text
        let cellHidden = cellState.dateBelongsTo != .thisMonth
        
        myCustomCell.isHidden = cellHidden
        myCustomCell.selectedView.backgroundColor = UIColor.black
        
        if Calendar.current.isDateInToday(cellState.date)
        {
            myCustomCell.selectedView.backgroundColor = UIColor.red
        }
        
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        handleCellSelection(view: myCustomCell, cellState: cellState)
        
        myCustomCell.eventView.isHidden = true
    }
    
    func handleCellSelection(view: CellView, cellState: CellState)
    {
        view.selectedView.isHidden = !cellState.isSelected
    }
    
    func handleCellTextColor(view: CellView, cellState: CellState)
    {
        if cellState.isSelected
        {
            view.dayLabel.textColor = UIColor.white
        }
        else
        {
            view.dayLabel.textColor = UIColor.black
            
            if cellState.day == .sunday || cellState.day == .saturday
            {
                view.dayLabel.textColor = UIColor.gray
            }
        }
        
        if Calendar.current.isDateInToday(cellState.date)
        {
            if cellState.isSelected
            {
                view.dayLabel.textColor = UIColor.white
            }
            else
            {
                view.dayLabel.textColor = UIColor.red
            }
        }
    }
}

// MARK: JTAppleCalendarViewDataSource
extension DisplayCalendarViewController: JTAppleCalendarViewDataSource
{
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters
    {
        formatter.dateFormat = dateFormatterString
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2030 02 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numOfRowsInCalendar,
                                                 calendar: Calendar.current,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday,
                                                 hasStrictBoundaries: true)
        return parameters
    }
}

// MARK: JTAppleCalendarViewDelegate
extension DisplayCalendarViewController: JTAppleCalendarViewDelegate
{
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath)
    {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: calendarCellIdentifier, for: indexPath) as! CellView
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell
    {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: calendarCellIdentifier, for: indexPath) as! CellView
        configureCell(view: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo)
    {
        setupViewsOfCalendar(from: visibleDates)
        if visibleDates.monthDates.first?.date == iii
        {
            return
        }
        
        iii = visibleDates.monthDates.first?.date
        
        select(onVisibleDates: visibleDates)
        
        view.layoutIfNeeded()
        
        adjustCalendarViewHeight()
        
        UIView.animate(withDuration: 0.5)
        { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState)
    {
        schedules.removeAll()
        
        schedules = databaseManager.retrieveScheduledGamesByDate(date)
        configureCell(view: cell, cellState: cellState)
        tableView.reloadData()
        tableView.contentOffset = CGPoint()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState)
    {
        schedules.removeAll()
        
        configureCell(view: cell, cellState: cellState)
    }
}

// MARK: UITableViewDataSource
extension DisplayCalendarViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: scheduleCellIdentifier, for: indexPath) as! ScheduleTableViewCell
        cell.selectionStyle = .none
        cell.schedule = schedules[indexPath.row]
        
        if(cell.noteLabel.text == "No games scheduled")
        {
            cell.noteLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            cell.categoryLine.isHidden = true
            tableView.separatorStyle = .none
        }
        else
        {
            cell.noteLabel.font = UIFont.systemFont(ofSize: 12.5)
            cell.categoryLine.isHidden = false
            tableView.separatorStyle = .singleLine
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return schedules.count
    }
}

