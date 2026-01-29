# SPDX-FileCopyrightText: 2023 ash_sqlite contributors <https://github.com/ash-project/ash_sqlite/graphs.contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshSqlite.Test.UpdateDeviceTest do
  use AshSqlite.RepoCase, async: false

  require Ash.Query

  test "updating a map attribute with update_timestamp works" do
    device =
      AshSqlite.Test.Device
      |> Ash.Changeset.for_create(:create, %{
        id: "1",
        name: "test",
        entity: %{}
      })
      |> Ash.create!()

    assert device.entity == %{}

    updated =
      device
      |> Ash.Changeset.for_update(:update_entity, %{
        entity: %{"upload_status" => "testing"}
      })
      |> Ash.update!()

    assert updated.entity == %{"upload_status" => "testing"}
  end

end
