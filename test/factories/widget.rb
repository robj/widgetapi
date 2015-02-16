FactoryGirl.define do

  factory :widget do

        name {"#{RandomWord.adjs.next}"}
        supplier {"#{RandomWord.adjs.next} Supplier"}
        cost {(1..99).to_a.sample}
  end


end
  