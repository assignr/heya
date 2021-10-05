# frozen_string_literal: true

require "active_record/relation"

module Heya
  module ActiveRecordRelationExtension
    TABLE_REGEXP = /heya_steps/

    def build_arel(aliases = nil)
      arel = super(aliases)

      if table_name == "heya_campaign_memberships" && arel.to_sql =~ TABLE_REGEXP
        # https://www.postgresql.org/docs/9.4/queries-values.html
        values = Heya
          .campaigns.reduce([]) { |steps, campaign| steps | campaign.steps }
          .map { |step|
            ActiveRecord::Base.sanitize_sql_array(
              [row_pair_syntax, step.gid, step.wait.to_i]
            )
          }

        if values.any?
          if ActiveRecord::Base.connection.adapter_name == "Mysql2"
            arel.with(
              Arel::Nodes::As.new(
                Arel::Table.new(:heya_steps),
                Arel::Nodes::SqlLiteral.new("(SELECT column_0 as gid, column_1 as wait FROM (VALUES #{values.join(", ")}) AS ht)")
              )
            )
          else
            arel.with(
              Arel::Nodes::As.new(
                Arel::Table.new(:heya_steps),
                Arel::Nodes::SqlLiteral.new("(SELECT * FROM (VALUES #{values.join(", ")}) AS heya_steps (gid,wait))")
              )
            )
          end
        end
      end

      arel
    end

    private

    def row_pair_syntax
      ActiveRecord::Base.connection.adapter_name == "Mysql2" ? "ROW (?, ?)" : "(?, ?)"
    end
  end

  ActiveRecord::Relation.prepend(ActiveRecordRelationExtension)
end
