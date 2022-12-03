class Formatter
  def output_report(context)
    raise 'Abstract method called'
  end
end

class HTMLReport < Formatter
  def output_report(context)
    puts "<html><head><title>#{context.title}</title></head>"
    puts "<h1>#{context.title}</h1>"
    puts "<pre>"
    context.text.each { |line| puts "<p>#{line}</p>" }
    puts "</pre>"
    puts "</body></html>"
  end
end

class PlainTextReport < Formatter
  def output_report(context)
    puts "****** #{context.title} *******"
    context.text.each { |line| puts line }
  end
end

class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = "This is title"
    @text = ['hello', 'world']
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(self)
  end
end

report = Report.new(HTMLReport.new)
report.output_report

report.formatter = PlainTextReport.new
report.output_report


