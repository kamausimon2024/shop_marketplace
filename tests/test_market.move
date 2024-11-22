#[test_only]
module preorder::test {
    use sui::test_scenario::{Self as ts, next_tx};
    use sui::coin::{mint_for_testing};
    use sui::sui::{SUI};

    use std::string::{Self, String};

    use preorder::helpers::init_test_helper;
    use preorder::preorder::{Self as order, Shop, Item, User, Installments, Admin};

    const ADMIN: address = @0xe;
    const TEST_ADDRESS1: address = @0xee;
    const TEST_ADDRESS2: address = @0xbb;

    #[test]
   //#[expected_failure(abort_code = 0x2::dynamic_field::EFieldDoesNotExist)]     
    public fun test1() {
        let mut scenario_test = init_test_helper();
        let scenario = &mut scenario_test;

        // test shared objects with init 
        next_tx(scenario, TEST_ADDRESS1);
        {
         
        };

        ts::end(scenario_test);
    }


}