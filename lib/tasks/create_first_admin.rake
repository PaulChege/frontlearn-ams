desc "creates the first admin user in the system"
task :create_first_admin => :environment do
	CreateFirstAdmin.invoke
end