view: kickstarter {
  sql_table_name: diegocam_thesis.kickstarter ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: backers {
    type: number
    sql: ${TABLE}.backers ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension_group: deadline {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.deadline ;;
  }

  dimension: goal {
    type: number
    sql: ${TABLE}.goal ;;
  }

  dimension_group: launched {
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
    sql: ${TABLE}.launched ;;
  }

  dimension: main_category {
    type: string
    sql: ${TABLE}.main_category ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: pledged {
    type: number
    sql: ${TABLE}.pledged ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: usd_goal_real {
    type: number
    sql: ${TABLE}.usd_goal_real ;;
  }

  dimension: usd_pledged {
    type: number
    sql: ${TABLE}.usd_pledged ;;
  }

  dimension: usd_pledged_real {
    type: number
    sql: ${TABLE}.usd_pledged_real ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }

  measure: sum_backers {
    type: sum
    sql: ${backers} ;;
  }


}
