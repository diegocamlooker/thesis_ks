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
    drill_fields: [name,launched_year]
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
    value_format: "0.##"
    sql: ${TABLE}.usd_goal_real ;;
  }

  dimension: usd_pledged {
    type: number
    value_format: "0.##"
    sql: ${TABLE}.usd_pledged ;;
  }



  dimension: usd_pledged_real {
    type: number
    value_format: "0.##"
    sql: ${TABLE}.usd_pledged_real ;;
  }

  dimension: eur_pledge_real
  {
    type: number
    value_format: "0.##"
    sql: 1.09 * ${usd_pledged_real};;
  }

  dimension: goal_vs_pledged {
    type: number
    value_format: "0.##"
    sql: (${usd_pledged_real} - ${usd_goal_real})/ (${usd_goal_real}*1.0) ;;
  }

  dimension: days_campaign {
    type: number
    sql: DATE_DIFF(${deadline_date},${launched_date},day) ;;
  }

  dimension: usd_goal_real_tier {
    type: tier
    tiers: [1000, 5000,10000,50000,100000,500000]
    value_format_name: usd
    style:classic
    sql: ${goal} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }

  measure: sum_backers {
    type: sum
    sql: ${backers} ;;
  }

  measure: average_backers {
    type: average
    value_format_name: decimal_0
    sql: ${backers} ;;
  }

  measure: average_funding_goal {
    type: average
    value_format_name: usd
    sql: ${usd_goal_real} ;;
  }

  measure: average_pledged {
    type: average
    value_format_name: usd
    sql: ${usd_pledged_real} ;;
  }

  measure: sum_usd_pledged_real {
    type: sum
    value_format_name: usd_0
    sql: ${usd_pledged_real} ;;
  }


  measure: average_days_campaign {
    type: average
    value_format_name: decimal_2
    sql: ${days_campaign} ;;
    }

#     overfunding dimensions only

  dimension: overfunded_yesno {
    type: yesno
    sql: ${usd_pledged_real} > ${usd_goal_real}  ;;
  }

  dimension: overfunded_times {
    type: number
    value_format_name: decimal_2
    sql:CASE WHEN ${overfunded_yesno} THEN (${usd_pledged_real} / ${usd_goal_real}) ELSE 0 END;;
    }

  dimension: overfunded_times_bucket {
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90]
    value_format_name: decimal_2
    style: integer
    sql:${overfunded_times};;
  }

#     linear regression model based on prediction  - not needed!

    # dimension: is_past {
    # type: number
    # sql: CASE WHEN ${launched_date} > CURRENT_DATE THEN 1 ELSE null END ;;
    # hidden: no
    # }

    # dimension: month_from_today {
    # type: number
    # sql: DATE_DIFF(${launched_date},current_date,month);;}

    # dimension: month_from_today_past {
    # type: number
    # sql: DATE_DIFF(${launched_date},current_date,month) * ${is_past};;}


#     timeframe vs timeframe analysis

## filter determining time range for all "A" measures

  filter: timeframe_a {
    type: date_time
  }

## flag for "A" measures to only include appropriate time range

  dimension: group_a_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_a %} ${launched_raw} {% endcondition %} ;;
  }

## filtered measure A

  measure: count_a {
    type: count
    filters: {
      field: group_a_yesno
      value: "yes"
    }
    drill_fields: [launched_date,name]
  }

## filter determining time range for all "B" measures

  filter: timeframe_b {
    type: date_time
  }

## flag for "B" measures to only include appropriate time range

  dimension: group_b_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_b %} ${launched_raw} {% endcondition %} ;;
  }

  measure: count_b {
    type: count
    filters: {
      field: group_b_yesno
      value: "yes"
    }
    drill_fields: [launched_date,name]
  }

## filter determining time range for all "C" measures

  filter: timeframe_c {
    type: date_time
  }

## flag for "C" measures to only include appropriate time range

  dimension: group_c_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_a %} ${launched_raw} {% endcondition %} ;;
  }

## filtered measure C

  measure: count_c {
    type: count
    filters: {
      field: group_a_yesno
      value: "yes"
    }
    drill_fields: [launched_date,name]
  }

## filter determining time range for all "D" measures

  filter: timeframe_d {
    type: date_time
  }

## flag for "D" measures to only include appropriate time range

  dimension: group_d_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_a %} ${launched_raw} {% endcondition %} ;;
  }

## filtered measure D

  measure: count_d {
    type: count
    filters: {
      field: group_a_yesno
      value: "yes"
    }
    drill_fields: [launched_date,name]
  }


  dimension: is_in_time_a_or_b_or_c_or_d {
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
    {% condition timeframe_a %} ${launched_raw} {% endcondition %} OR
    {% condition timeframe_b %} ${launched_raw} {% endcondition %} OR
    {% condition timeframe_c %} ${launched_raw} {% endcondition %} OR
    {% condition timeframe_d %} ${launched_raw} {% endcondition %} ;;
  }



}
