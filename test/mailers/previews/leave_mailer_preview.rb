# Preview all emails at http://localhost:3000/rails/mailers/leave_mailer
class LeaveMailerPreview < ActionMailer::Preview

	def approve_email
      @leave = Leave.find 2
      LeaveMailer.approve_email(@leave)
	end

end
