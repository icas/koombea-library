Fabricator(:role)

# as we need to specify a diferent role for each test
# it´s better to set the role manually for each test
# insttead of creating a Fabricator for each role
#
# Fabricate(:role) do
#   role "Admin"
# end
#
# Fabricate(:role) do
#   role "root"
# end
#
# and so on..