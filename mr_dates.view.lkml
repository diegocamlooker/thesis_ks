view: mr_dates {

  dimension_group: date_future {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_id ;;
  }


}
