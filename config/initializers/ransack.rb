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
end
