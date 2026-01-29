# SPDX-FileCopyrightText: 2023 ash_sqlite contributors <https://github.com/ash-project/ash_sqlite/graphs.contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshSqlite.Test.Device do
  @moduledoc false
  use Ash.Resource,
    domain: AshSqlite.Test.Domain,
    data_layer: AshSqlite.DataLayer

  sqlite do
    table("devices")
    repo(AshSqlite.TestRepo)
  end

  actions do
    destroy :destroy do
      primary? true
      accept [:id]
    end

    read :read do
      primary? true
    end

    create :create do
      primary? true
      accept [:id, :name, :entity]
      upsert? true
      upsert_identity :unique_id
    end

    update :update_entity do
      accept [:entity]

      # change set_attribute(:updated_at, DateTime.utc_now())
    end
  end

  attributes do
    attribute :id, :string do
      writable? true
      generated? false
      primary_key? true
      allow_nil? false
    end

    attribute :name, :string do
      description "The name of the device"
      allow_nil? false
      public? true
    end

    attribute :entity, :map do
      allow_nil? false
      public? true
    end

    timestamps()
  end

  identities do
    identity :unique_id, [:id]
  end
end
