require 'test_helper'

class ProjectMailerTest < ActionMailer::TestCase
  test "project_create" do
    mail = ProjectMailer.project_create
    assert_equal "Project create", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
