class Acronym
  def self.abbreviate(str)
    str
      .split(/[\s-]/)
      .reject(&:empty?)
      .map { |s| s[0].capitalize }
      .select { |char| ('A'..'Z').include?(char) }
      .join
  end
end
