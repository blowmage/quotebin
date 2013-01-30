json.id quote.id
json.author    quote.author
json.quotation quote.quotation
json.source    quote.source
json.url       quote.url
json.tags      quote.tag_list

json.owner do
  json.id       quote.owner.id
  json.username quote.owner.username
  json.name     quote.owner.name
  json.email    quote.owner.email
end
