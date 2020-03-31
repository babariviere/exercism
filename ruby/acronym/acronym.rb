class Acronym
  def self.abbreviate(str)
    str
      .scan(/([\b\w])\w*/)
      .flatten
      .map(&:capitalize)
      .join
  end
end
