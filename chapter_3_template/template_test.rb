require 'test/unit'
require_relative 'template.rb'

class ReportTest < Test::Unit::TestCase
  def setup
    @report = HTMLReport.new
  end

  def test_html_report
    assert @report
    # assert_equal "", @report.output_report
  end
end
