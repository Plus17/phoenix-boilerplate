defmodule AppName.Seeds.AdminSeedTest do
  use AppName.DataCase

  alias AppName.Repo

  alias AppName.Seeds.AdminSeed

  alias AppName.Contexts.Users.User
  alias AppName.Contexts.Users.UserManager

  describe "run/0" do
    test "creates the seed data" do
      AdminSeed.run()

      assert %{entries: [admin_user]} = UserManager.list()
      assert admin_user.is_admin
    end

    test "seeds only creates 1 admin" do
      AdminSeed.run()
      AdminSeed.run()

      assert Repo.aggregate(User, :count, :id) == 1
    end
  end
end
