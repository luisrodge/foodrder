class AddPgPseudoEncryptFunction < ActiveRecord::Migration[5.1]
  def up
    connection.execute(%q{
      CREATE OR REPLACE FUNCTION pseudo_encrypt(VALUE int) returns bigint AS $$
      DECLARE
      l1 int;
      l2 int;
      r1 int;
      r2 int;
      i int:=0;
      BEGIN
       l1:= (VALUE >> 16) & 65535;
       r1:= VALUE & 65535;
       WHILE i < 3 LOOP
         l2 := r1;
         r2 := l1 # ((((1366.0 * r1 + 150889) % 714025) / 714025.0) * 32767)::int;
         l1 := l2;
         r1 := r2;
         i := i + 1;
       END LOOP;
       RETURN ((l1::bigint << 16) + r1);
      END;
      $$ LANGUAGE plpgsql strict immutable;

      create sequence random_int_seq;

      create function make_random_id() returns bigint as $$
        select pseudo_encrypt(nextval('random_int_seq')::int) as bigint
      $$ language sql;

    })
  end

  def down
    connection.execute(%q{
      drop function psuedo_encrypt(int);
      drop function make_random_id();
    })
  end
end
