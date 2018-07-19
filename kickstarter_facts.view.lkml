view: kickstarter_facts {
  derived_table: {
    sql: -- generate derived table kickstarter_facts
      -- running the following sql through the bigquery API to create table as select:
      -- Building diegocam_thesis::kickstarter_facts in dev mode on instance 353ba745759ae06280e04aa875a6da88
      SELECT kickstarter.launched,
          MAX(bgg.rank) as max_rank,
          MAX(kickstarter.usd_pledged_real) as max_pledge,
          MIN(kickstarter.usd_pledged_real) as min_pledge,
          MAX(bgg.geek_rating) as best_game_rating,
          MIN(bgg.geek_rating) as worst_game_rating
          FROM `lookerdata.diegocam_thesis.kickstarter` as kickstarter,`lookerdata.diegocam_thesis.bgg` as bgg,`lookerdata.diegocam_thesis.collection` as collection
            WHERE kickstarter.category IN ("Tabletop Games") and kickstarter.state IN ("successful")

      GROUP BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: launched {
    type: time
    sql: ${TABLE}.launched ;;
  }

  dimension: max_rank {
    type: number
    sql: ${TABLE}.max_rank ;;
  }

  dimension: max_pledge {
    type: number
    sql: ${TABLE}.max_pledge ;;
  }

  dimension: min_pledge {
    type: number
    sql: ${TABLE}.min_pledge ;;
  }

  dimension: best_game_rating {
    type: number
    sql: ${TABLE}.best_game_rating ;;
  }

  dimension: worst_game_rating {
    type: number
    sql: ${TABLE}.worst_game_rating ;;
  }

  set: detail {
    fields: [
      launched_time,
      max_rank,
      max_pledge,
      min_pledge,
      best_game_rating,
      worst_game_rating
    ]
  }
}
