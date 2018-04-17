Ransack.configure do |c|
  c.custom_arrows = {
    up_arrow: '&#x25b2;',
    down_arrow: '&#x25bc;',
    default_arrow: '&#x25bc;'
  }

  c.sanitize_custom_scope_booleans = false
  # fix to bug causing not returning results from custom scopes when non-boolean
  # values 0 and 1 passed
  # https://github.com/activerecord-hackery/ransack/pull/742
end
