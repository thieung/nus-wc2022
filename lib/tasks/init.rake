require 'csv'
namespace :db do
  task :generate_staffs, [:role] => :environment do
    csv_staffs_raw = File.read("#{Rails.root}/db/data/staffs.csv")
    # Header: full_name,email
    csv_staffs = CSV.parse(csv_staffs_raw, headers: true)
    csv_staffs.each do |row|
      staff = User.find_by_email(row['email'])
      unless staff
        # generated_password = Devise.friendly_token.first(8)
        generated_password = "12344321"
        staff = User.new(
          full_name: row['full_name'],
          username: row['email'].split('@').first.downcase,
          email: row['email'],
          password: generated_password
        )
        if staff.save
          staff.add_role :staff
          # UserMailer.delay.send_password_to_staff(staff, generated_password)

          # Generate predict champion data for each staff
          predict = user.predict_champions.new(money: 100000)
          predict.save
        end
      end
    end
  end
end