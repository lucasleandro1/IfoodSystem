Ransack.configure do |config|
  config.add_predicate "eq_any",
    arel_predicate: "in",
    formatter: proc { |v| v.split(",").map(&:strip) }
end
