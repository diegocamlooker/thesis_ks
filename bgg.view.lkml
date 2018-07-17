view: bgg {
  sql_table_name: diegocam_thesis.bgg ;;

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: avg_rating {
    type: number
    sql: ${TABLE}.avg_rating ;;
  }

  dimension: avg_time {
    type: number
    sql: ${TABLE}.avg_time ;;
  }

  dimension: bgg_url {
    type: string
    sql: ${TABLE}.bgg_url ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: designer {
    type: string
    sql: ${TABLE}.designer ;;
  }

  dimension: game_id {
    type: number
    sql: ${TABLE}.game_id ;;
  }

  dimension: geek_rating {
    type: number
    sql: ${TABLE}.geek_rating ;;
  }

  dimension: image_url {
    type: string
    sql: ${TABLE}.image_url ;;
  }

  dimension: max_players {
    type: number
    sql: ${TABLE}.max_players ;;
  }

  dimension: max_time {
    type: number
    sql: ${TABLE}.max_time ;;
  }

  dimension: mechanic {
    type: string
    sql: ${TABLE}.mechanic ;;
  }

  dimension: min_players {
    type: number
    sql: ${TABLE}.min_players ;;
  }

  dimension: min_time {
    type: number
    sql: ${TABLE}.min_time ;;
  }

  dimension: names {
    type: string
    sql: ${TABLE}.names ;;
  }

  dimension: num_votes {
    type: number
    sql: ${TABLE}.num_votes ;;
  }

  dimension: owned {
    type: number
    sql: ${TABLE}.owned ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }


set: detail {
  fields: [rank,weight,year,owned,image_url,geek_rating,names]
}
}
