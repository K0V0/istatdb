Ransack.configure do |c|
  c.custom_arrows = {
    up_arrow: '<b>&#x25b2;</b>',
    down_arrow: '<b>&#x25bc;</b>',
    default_arrow: '<b>&#x25bc;</b>'
  }

  c.sanitize_custom_scope_booleans = false
  # fix to bug causing not returning results from custom scopes when non-boolean
  # values 0 and 1 passed
  # https://github.com/activerecord-hackery/ransack/pull/742
  #
  c.add_predicate('cont_intel', # Name your predicate
    # What non-compound ARel predicate will it use? (eq, matches, etc)
    arel_predicate: 'matches',
    # Format incoming values as you see fit. (Default: Don't do formatting)
    formatter: proc { |v| "%#{v}%" },
    # Validate a value. An "invalid" value won't be used in a search.
    # Below is default.
    validator: proc { |v| v.present? },
    # Should compounds be created? Will use the compound (any/all) version
    # of the arel_predicate to create a corresponding any/all version of
    # your predicate. (Default: true)
    compounds: true,
    # Force a specific column type for type-casting of supplied values.
    # (Default: use type from DB column)
    case_insensitive: true,
    # Use LOWER(column on database).
    # (Default: false)
    type: :string)

end
