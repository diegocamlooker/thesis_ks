view: sql_runner_query {
  derived_table: {
    sql: SELECT * FROM `lookerdata.diegocam_thesis.bgg` LIMIT 10
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: bgg_url {
    type: string
    sql: ${TABLE}.bgg_url ;;
  }

  dimension: game_id {
    type: number
    sql: ${TABLE}.game_id ;;
  }

  dimension: names {
    type: string
    sql: ${TABLE}.names ;;
  }

  dimension: min_players {
    type: number
    sql: ${TABLE}.min_players ;;
  }

  dimension: max_players {
    type: number
    sql: ${TABLE}.max_players ;;
  }

  dimension: avg_time {
    type: number
    sql: ${TABLE}.avg_time ;;
  }

  dimension: min_time {
    type: number
    sql: ${TABLE}.min_time ;;
  }

  dimension: max_time {
    type: number
    sql: ${TABLE}.max_time ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: avg_rating {
    type: number
    sql: ${TABLE}.avg_rating ;;
  }

  dimension: geek_rating {
    type: number
    sql: ${TABLE}.geek_rating ;;
  }

  dimension: num_votes {
    type: number
    sql: ${TABLE}.num_votes ;;
  }

  dimension: image_url {
    type: string
    sql: ${TABLE}.image_url ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: mechanic {
    type: string
    sql: ${TABLE}.mechanic ;;
  }

  dimension: owned {
    type: number
    sql: ${TABLE}.owned ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: designer {
    type: string
    sql: ${TABLE}.designer ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  set: detail {
    fields: [
      rank,
      bgg_url,
      game_id,
      names,
      min_players,
      max_players,
      avg_time,
      min_time,
      max_time,
      year,
      avg_rating,
      geek_rating,
      num_votes,
      image_url,
      age,
      mechanic,
      owned,
      category,
      designer,
      weight
    ]
  }
}
