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
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    sql: ${TABLE}.usd_goal_real ;;
  }

  dimension: usd_pledged {
    type: number
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    sql: ${TABLE}.usd_pledged ;;
  }



  dimension: usd_pledged_real {
    type: number
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    sql: ${TABLE}.usd_pledged_real ;;
  }

  dimension: eur_pledge_real
  {
    type: number
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
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
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    style:classic
    sql: ${goal} ;;
  }


  dimension: usd_pledged_real_backer {
    type: number
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    sql: ${usd_pledged_real}/${backers} ;;
  }


  measure: count {
    type: count
    drill_fields: [id, name,usd_pledged_real]
  }

  measure: count_project {
    type: count_distinct
    sql: ${name} ;;
    drill_fields: [id, name,backers,usd_pledged_real]
  }

  measure: sum_backers {
    type: sum
    sql: ${backers} ;;
    drill_fields: [id, name,backers,usd_pledged_real]
  }

  measure: average_backers {
    type: average
    value_format_name: decimal_0
    sql: ${backers} ;;
    drill_fields: [id, name,backers,usd_pledged_real]
  }

  measure: average_funding_goal {
    type: average
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    sql: ${usd_goal_real} ;;
    drill_fields: [id, name,backers,usd_pledged_real]
  }

  measure: average_pledged {
    type: average
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    sql: ${usd_pledged_real} ;;
    drill_fields: [id, name,backers,usd_pledged_real]
  }

  measure: sum_usd_pledged {
    type: sum
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    sql: ${usd_pledged} ;;
    drill_fields: [id, name,backers,usd_pledged_real]
  }

  measure: sum_usd_pledged_real {
    type: sum
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    sql: ${usd_pledged_real} ;;
    drill_fields: [id, name,backers,usd_pledged_real]
  }


  measure: average_days_campaign {
    type: average
    value_format_name: decimal_2
    sql: ${days_campaign} ;;
    drill_fields: [id, name,backers,usd_pledged_real]
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
    tiers: [0,2,5,10,20,50,100]
    value_format_name: decimal_2
    style: integer
    sql:${overfunded_times};;
  }

  measure:  overfunded_avg {
    type: average
    value_format_name: decimal_0
    sql: ${overfunded_times};;
    drill_fields: [id, name,usd_pledged_real]
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
    label: "Time Comparison"
    type: date_time
  }

## flag for "A" measures to only include appropriate time range

  dimension: group_a_yesno {
    hidden: yes
    label: "Time Comparison"
    type: yesno
    sql: {% condition timeframe_a %} ${launched_raw} {% endcondition %} ;;
  }

## filtered measure A

  measure: count_a {
    type: count
    group_label: "Time Comparison"
    filters: {
      field: group_a_yesno
      value: "yes"
    }
    drill_fields: [launched_date,name]
  }

  measure: avg_over_a {
    type: average
    group_label: "Time Comparison"
    filters: {
      field: group_a_yesno
      value: "yes"
    }
    sql: ${overfunded_times} ;;
    value_format_name: decimal_1
    drill_fields: [launched_date,name]
  }

## filter determining time range for all "B" measures

  filter: timeframe_b {
    type: date_time
  }

## flag for "B" measures to only include appropriate time range

  dimension: group_b_yesno {
    hidden: yes
    group_label:  "Time Comparison"
    type: yesno
    sql: {% condition timeframe_b %} ${launched_raw} {% endcondition %} ;;
  }

  measure: count_b {
    type: count
    group_label: "Time Comparison"
    filters: {
      field: group_b_yesno
      value: "yes"
    }
    drill_fields: [launched_date,name]
  }

  measure: avg_over_b {
    type: average
    group_label: "Time Comparison"
    filters: {
      field: group_b_yesno
      value: "yes"
    }
    sql: ${overfunded_times} ;;
    value_format_name: decimal_1
    drill_fields: [launched_date,name]
  }

## filter determining time range for all "C" measures

  filter: timeframe_c {
    type: date_time

  }

## flag for "C" measures to only include appropriate time range

  dimension: group_c_yesno {
    hidden: yes
    group_label: "Time Comparison"
    type: yesno
    sql: {% condition timeframe_c %} ${launched_raw} {% endcondition %} ;;
  }

## filtered measure C

  measure: count_c {
    type: count
    group_label: "Time Comparison"
    filters: {
      field: group_c_yesno
      value: "yes"
    }
    drill_fields: [launched_date,name]
  }

  measure: avg_over_c {
    type: average
    group_label: "Time Comparison"
    filters: {
      field: group_c_yesno
      value: "yes"
    }
    sql: ${overfunded_times} ;;
    value_format_name: decimal_1
    drill_fields: [launched_date,name]
  }

## filter determining time range for all "D" measures

  filter: timeframe_d {
    type: date_time
  }

## flag for "D" measures to only include appropriate time range

  dimension: group_d_yesno {
    hidden: yes
    group_label: "Time Comparison"
    type: yesno
    sql: {% condition timeframe_d %} ${launched_raw} {% endcondition %} ;;
  }

## filtered measure D

  measure: count_d {
    type: count
    group_label: "Time Comparison"
    filters: {
      field: group_d_yesno
      value: "yes"
    }
    drill_fields: [launched_date,name]
  }

  measure: avg_over_d {
    type: average
    group_label: "Time Comparison"
    filters: {
      field: group_d_yesno
      value: "yes"
    }
    sql: ${overfunded_times} ;;
    value_format_name: decimal_1
    drill_fields: [launched_date,name]
  }

  dimension: is_in_time_a_or_b_or_c_or_d {
    group_label: "Time Comparison"
    type: yesno
    sql:
    {% condition timeframe_a %} ${launched_raw} {% endcondition %} OR
    {% condition timeframe_b %} ${launched_raw} {% endcondition %} OR
    {% condition timeframe_c %} ${launched_raw} {% endcondition %} OR
    {% condition timeframe_d %} ${launched_raw} {% endcondition %} ;;
  }


  # peer comparison: Tabletop vs Rest of Categories

 filter: category_select {
  type: string
  suggest_dimension: category }

dimension: category_comparitor {
  sql:CASE
      WHEN {% condition category_select %} ${category} {% endcondition %}
        THEN ${category}
      ELSE 'Rest of Population'
    END
  ;;}

}
