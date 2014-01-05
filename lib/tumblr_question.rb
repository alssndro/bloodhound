class TumblrQuestion
  attr_reader :question, :answer, :question_url, :asked_on

  def initialize(question_hash)
    @question = question_hash["question"]

    # Remove html tags
    @answer = question_hash["answer"]
    @question_url = question_hash[question_hash]
    @asked_on = Time.at(question_hash["timestamp"]).strftime("%b %e %Y")
  end
end