require 'csv'
namespace :db do
  task :generate_staffs, [:role] => :environment do
    csv_staffs_raw = File.read("#{Rails.root}/db/data/euro2020/staffs.csv")
    # Header: full_name,email
    csv_staffs = CSV.parse(csv_staffs_raw, headers: true)
    csv_staffs.each do |row|
      staff = User.find_by_email(row['email'])
      unless staff
        generated_password = Settings.is_demo ? '12345678' : Devise.friendly_token.first(8)
        staff = User.new(
          full_name: row['full_name'],
          username: row['email'].split('@').first.downcase,
          email: row['email'],
          password: generated_password
        )
        if staff.save
          staff.add_role :staff
          UserMailer.delay.send_password_to_staff(staff, generated_password) if !Settings.is_turn_off_mail && !Settings.is_demo

          # Generate predict champion data for each staff
          predict = staff.predict_champions.new(money: Settings.predict_champion_money.first)
          predict.save
        end
      end
    end
  end
end
