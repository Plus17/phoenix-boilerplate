defmodule AppName.Contexts.Users.UserManagerTest do
  use AppName.DataCase

  alias AppName.Contexts.Users.UserManager

  describe "list/0" do
    test "when doesn't exists users" do
      assert UserManager.list() == []
    end

    test "returns all users" do
      insert(:user)
      assert [_user] = UserManager.list()
    end
  end

  describe "create_admin/1" do
    test "when data is valid" do
      email = unique_user_email()
      password = valid_user_password()

      assert {:ok, user} =
               UserManager.create_admin(%{email: email, password: password, is_admin: true})

      assert user.is_admin
    end
  end
end
