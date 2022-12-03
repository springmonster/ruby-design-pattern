class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = "title"
    @text = ["hello", "world"]
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

HTML_REPORT = lambda do |context|
  puts "<html><head><title>#{context.title}</title></head>"
  puts "<h1>#{context.title}</h1>"
  puts "<pre>"
  context.text.each { |line| puts "<p>#{line}</p>" }
  puts "</pre>"
  puts "</body></html>"
end

PLAINTEXT_REPORT = lambda do |context|
  puts "****** #{context.title} *******"
  context.text.each { |line| puts line }
end

# &是block的时候需要的关键字
report = Report.new &HTML_REPORT
report.output_report

report = Report.new &PLAINTEXT_REPORT
report.output_report
