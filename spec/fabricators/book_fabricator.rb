# t.string   "title"
# t.integer  "author_id"
# t.integer  "editorial_id"
# t.date     "published_date"
# t.string   "format"
Fabricator(:book) do
  title { Faker::Lorem.words(4).join(" ") }
  author
  editorial
  published_date Date.today
  format { %w(digital paper).sample }
end