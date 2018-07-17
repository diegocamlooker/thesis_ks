view: collection {
  sql_table_name: diegocam_thesis.collection ;;

  dimension: acquiredfrom {
    type: string
    sql: ${TABLE}.acquiredfrom ;;
  }

  dimension: acquisitiondate {
    type: string
    sql: ${TABLE}.acquisitiondate ;;
  }

  dimension: average {
    type: number
    sql: ${TABLE}.average ;;
  }

  dimension: avgweight {
    type: number
    sql: ${TABLE}.avgweight ;;
  }

  dimension: baverage {
    type: number
    sql: ${TABLE}.baverage ;;
  }

  dimension: bgglanguagedependence {
    type: string
    sql: ${TABLE}.bgglanguagedependence ;;
  }

  dimension: bggrecagerange {
    type: string
    sql: ${TABLE}.bggrecagerange ;;
  }

  dimension: collid {
    type: number
    value_format_name: id
    sql: ${TABLE}.collid ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: conditiontext {
    type: string
    sql: ${TABLE}.conditiontext ;;
  }

  dimension: currvalue {
    type: string
    sql: ${TABLE}.currvalue ;;
  }

  dimension: cv_currency {
    type: string
    sql: ${TABLE}.cv_currency ;;
  }

  dimension: fortrade {
    type: number
    sql: ${TABLE}.fortrade ;;
  }

  dimension: haspartslist {
    type: string
    sql: ${TABLE}.haspartslist ;;
  }

  dimension: imageid {
    type: string
    sql: ${TABLE}.imageid ;;
    html: <img src="{{value}}" /> ;;
  }

  dimension: invdate {
    type: string
    sql: ${TABLE}.invdate ;;
  }

  dimension: invlocation {
    type: string
    sql: ${TABLE}.invlocation ;;
  }

  dimension: itemtype {
    type: string
    sql: ${TABLE}.itemtype ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: maxplayers {
    type: number
    sql: ${TABLE}.maxplayers ;;
  }

  dimension: maxplaytime {
    type: number
    sql: ${TABLE}.maxplaytime ;;
  }

  dimension: minplayers {
    type: number
    sql: ${TABLE}.minplayers ;;
  }

  dimension: minplaytime {
    type: number
    sql: ${TABLE}.minplaytime ;;
  }

  dimension: numowned {
    type: number
    sql: ${TABLE}.numowned ;;
  }

  dimension: numplays {
    type: number
    sql: ${TABLE}.numplays ;;
  }

  dimension: objectid {
    type: number
    value_format_name: id
    sql: ${TABLE}.objectid ;;
  }

  dimension: objectname {
    type: string
    sql: ${TABLE}.objectname ;;
  }

  dimension: objecttype {
    type: string
    sql: ${TABLE}.objecttype ;;
  }

  dimension: originalname {
    type: string
    sql: ${TABLE}.originalname ;;
  }

  dimension: other {
    type: string
    sql: ${TABLE}.other ;;
  }

  dimension: own {
    type: number
    sql: ${TABLE}.own ;;
  }

  dimension: playingtime {
    type: number
    sql: ${TABLE}.playingtime ;;
  }

  dimension: pp_currency {
    type: string
    sql: ${TABLE}.pp_currency ;;
  }

  dimension: preordered {
    type: number
    sql: ${TABLE}.preordered ;;
  }

  dimension: prevowned {
    type: number
    sql: ${TABLE}.prevowned ;;
  }

  dimension: pricepaid {
    type: string
    sql: ${TABLE}.pricepaid ;;
  }

  dimension: privatecomment {
    type: string
    sql: ${TABLE}.privatecomment ;;
  }

  dimension: publisherid {
    type: string
    sql: ${TABLE}.publisherid ;;
  }

  dimension: quantity {
    type: string
    sql: ${TABLE}.quantity ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
  }

  dimension: version_languages {
    type: string
    sql: ${TABLE}.version_languages ;;
  }

  dimension: version_nickname {
    type: string
    sql: ${TABLE}.version_nickname ;;
  }

  dimension: version_publishers {
    type: string
    sql: ${TABLE}.version_publishers ;;
  }

  dimension: version_yearpublished {
    type: string
    sql: ${TABLE}.version_yearpublished ;;
  }

  dimension: want {
    type: number
    sql: ${TABLE}.want ;;
  }

  dimension: wantpartslist {
    type: string
    sql: ${TABLE}.wantpartslist ;;
  }

  dimension: wanttobuy {
    type: number
    sql: ${TABLE}.wanttobuy ;;
  }

  dimension: wanttoplay {
    type: number
    sql: ${TABLE}.wanttoplay ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  dimension: wishlist {
    type: number
    sql: ${TABLE}.wishlist ;;
  }

  dimension: wishlistcomment {
    type: string
    sql: ${TABLE}.wishlistcomment ;;
  }

  dimension: wishlistpriority {
    type: number
    sql: ${TABLE}.wishlistpriority ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  dimension: yearpublished {
    type: number
    sql: ${TABLE}.yearpublished ;;
  }

  measure: count {
    type: count
    drill_fields: [originalname, objectname, version_nickname]
  }

  measure: sum_plays {
    type: sum
    sql: ${numplays} ;;
    drill_fields: [originalname]

  }  measure: sum_own {
    type: sum
    sql: ${own} ;;
    drill_fields: [originalname]
  }

  set: detail {
    fields: [numplays,rating,own,wishlist,originalname,imageid]
  }

}
