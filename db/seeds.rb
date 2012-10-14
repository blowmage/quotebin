def create_quote(quotation, author, tag_list)
  found = Quote.find_or_initialize_by_quotation_and_author(quotation, author)
  found.tag_list = tag_list
  found.save
  found
end

quotes = ["Be kind whenever possible. It is always possible.", "Dalai Lama", "kindness"],
["Happiness is not something ready made. It comes from your own actions.", "Dalai Lama", "responsibility"],
["This is my simple religion. There is no need for temples; no need for complicated philosophy. Our own brain, our own heart is our temple; the philosophy is kindness.", "Dalai Lama", "common perspective"],
["All major religious traditions carry basically the same message, that is love, compassion and forgiveness the important thing is they should be part of our daily lives.", "Dalai Lama", "common perspective"],
["It is very important to generate a good attitude, a good heart, as much as possible. From this, happiness in both the short term and the long term for both yourself and others will come.", "Dalai Lama", "happiness"],
["Old friends pass away, new friends appear. It is just like the days. An old day passes, a new day arrives. The important thing is to make it meaningful: a meaningful friend - or a meaningful day.", "Dalai Lama", "meaningful, purpose-driven"],
["Love and compassion are necessities, not luxuries. Without them humanity cannot survive.", "Dalai Lama", "priorities"],
["I find hope in the darkest of days, and focus in the brightest. I do not judge the universe.", "Dalai Lama", "without judgement"],
["My religion is very simple. My religion is kindness.", "Dalai Lama", "kindness"],
["Our prime purpose in this life is to help others. And if you can't help them, at least don't hurt them.", "Dalai Lama", "kindness"],
["There is no need for temples, no need for complicated philosophies. My brain and my heart are my temples; my philosophy is kindness.", "Dalai Lama", "kindness, common perspective"],
["If you can, help others; if you cannot do that, at least do not harm them.", "Dalai Lama", "kindness"],
["If you want others to be happy, practice compassion. If you want to be happy, practice compassion.", "Dalai Lama", "happiness"],
["In the practice of tolerance, one's enemy is the best teacher.", "Dalai Lama", "learning, tolerance"],
["Sleep is the best meditation.", "Dalai Lama", "priorities"],
["Sometimes one creates a dynamic impression by saying something, and sometimes one creates as significant an impression by remaining silent.", "Dalai Lama", "wisdom"],
["It is necessary to help others, not only in our prayers, but in our daily lives. If we find we cannot help others, the least we can do is to desist from harming them.", "Dalai Lama", "kindness"],
["The purpose of our lives is to be happy.", "Dalai Lama", "happiness"],
["We can never obtain peace in the outer world until we make peace with ourselves.", "Dalai Lama", "happiness"],
["Today, more than ever before, life must be characterized by a sense of Universal responsibility, not only nation to nation and human to human, but also human to other forms of life.", "Dalai Lama", "responsibility"],
["If you have a particular faith or religion, that is good. But you can survive without it.", "Dalai Lama", "common perspective"],
["We can live without religion and meditation, but we cannot survive without human affection.", "Dalai Lama", "common perspective"],
["With realization of one's own potential and self-confidence in one's ability, one can build a better world.", "Dalai Lama", "empowerment"],
["Where ignorance is our master, there is no possibility of real peace.", "Dalai Lama", "happiness"],
["Whether one believes in a religion or not, and whether one believes in rebirth or not, there isn't anyone who doesn't appreciate kindness and compassion.", "Dalai Lama", "kindness, common perspective"]

@built = quotes.each {|array| create_quote(*array)}
