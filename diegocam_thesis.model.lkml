connection: "lookerdata_standard_sql"

# include all the views
include: "*.view"

# No need for a datagroup - stale dataset
# datagroup: diegocam_thesis_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }

# persist_with: diegocam_thesis_default_datagroup

explore: bgg {
  description: "Complete Boardgame Geek Dataset"
  hidden: no
  label: "BGG"
  group_label: "Diego thesis"
  view_label: "Boardgame data"
}

explore: collection {
  description: "A csv with all the info from the games I interacted with"
  hidden: no
  label: "Collection"
  group_label: "Diego thesis"
  view_label: "My collection"
}

explore: kickstarter {
  description: "Explore KS freely!"
  hidden: no
  label: "KS"
  group_label: "Diego thesis"
  view_label: "Kickstarter"
}

explore: kickstarter_boardgames {
  from: kickstarter
  hidden: no
  sql_always_where: ${category} IN ("Tabletop Games") and ${state} IN ("successful","failed");;
  description: "Only Boardgames projects in KS"
  label: "KS boardgames"
  group_label: "Diego thesis"
  view_label: "Kickstarter - Boardgames"
}

# explore: kickstarter_prediction {
#   from: kickstarter
#   hidden: no
#   sql_always_where: ${category} IN ("Tabletop Games") and ${state} IN ("successful","failed");;
#   description: "To help predicting FUTURE!"
#   label: "KS boardgames - Prediction "
#   group_label: "Diego thesis"
#   view_label: "Kickstarter - Boardgames - Prediction model"
#   join: mr_dates {
#     from: mr_dates
#     sql_on:${mr_dates.date_future_date}=${kickstarter_prediction.launched_date}  ;;
#     type: full_outer
#     relationship: many_to_many
#   }
# }

explore: kickstarter_facts {
  hidden: no
  description: "Interesting facts"
  group_label: "Diego thesis"
  label: "KS facts"
  view_label: "Kickstarter - Facts"
}

# explore: mr_dates {
#   hidden: no

# }

explore: boardgames_all {
  description: "All tables joined"
  view_label: "KS"
  group_label: "Diego thesis"
  hidden: no
  from: kickstarter
  join: bgg {
    from: bgg
    fields: [bgg.detail*]
    type: left_outer
    sql_on: ${boardgames_all.name}=${bgg.names} ;;
    relationship: one_to_one
  }
  join: collection {
    from:  collection
    fields: [collection.detail*]
    type: left_outer
    sql_on: ${bgg.names}=${collection.originalname}  ;;
    relationship: one_to_one
  }
}
