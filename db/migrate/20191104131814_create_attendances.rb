class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.string :stripe_customer_id

      # On rajoute les clés externes 'event_id'


      # On rajoute les clés externes correspondant
      # aux administrateurs, aux participants et aux événements
      t.references :attendant, index: true
      t.references :administrator, index: true

      t.references :event, foreign_key: true, index: true

      t.timestamps
    end
  end
end
