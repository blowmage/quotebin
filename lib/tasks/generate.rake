namespace :generate do
  FIRST_NAMES = %w(Aaron James John Robert Michael William David Richard Charles Joseph Daniel Paul
                   Mary Linda Sarah Elizabeth Maria Susan Lisa Nancy Karen Emily Julie Kimberly Zach)
  LAST_NAMES  = %w(Hill Nelson Young Smith Johnson Jones Miller Wilson Moore Taylor Anderson Jackson 
                   Baker Clark Crawford Patterson Gray Ward Edwards Ferguson Rodriguez Robinson Ross)
  TAG_WORDS   = %w(politics family parenting dogs sleep social writing fun election love crime animals
                   advice equations communication websites marriage voting society general cars movies)

  desc "generate a bunch of random quotes"
  task :quotes => :environment do
    words = []
    File.open("/usr/share/dict/words").each_line {|line| words << line.strip}
    user = User.first
    10000.times do
      quotation = []
      rand(80).times {quotation << words.sample}
      quote = Quote.create(
        quotation: quotation.join(" "),
        author: "#{FIRST_NAMES.sample} #{LAST_NAMES.sample}"
      )
      quote.owner_id = user.id 
      quote.tag_list = "#{TAG_WORDS.sample}, #{TAG_WORDS.sample}"
      quote.save!
    end
  end
end