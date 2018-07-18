view: kickstarter_facts {
  derived_table: {
    sql: SELECT MAX(usd_pledged_real) ,MIN(usd_pledged_real) FROM `lookerdata.diegocam_thesis.kickstarter`
      WHERE category IN ("Tabletop Games") and state IN ("successful")
       ;;
  }

  dimension: max_pledge {
    type: number
    sql: ${TABLE}.f0_ ;;
  }

  dimension: min_pledge {
    type: number
    sql: ${TABLE}.f1_ ;;
  }

  set: detail {
    fields: [max_pledge, min_pledge]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


}
