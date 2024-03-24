// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BokoToken} from "../../src/BokoToken.sol";
import {DeployBokoToken} from "../../script/DeployBokoToken.s.sol";

contract BokoTokenTest is Test {
    BokoToken public bokoToken;
    DeployBokoToken public deployBokoToken;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    function setUp() public {
        deployBokoToken = new DeployBokoToken();
        bokoToken = deployBokoToken.run();

        vm.prank(msg.sender);
        bokoToken.transfer(bob, 100 ether);
    }

    function testBobHasCorrectBalance() public {
        assertEq(bokoToken.balanceOf(bob), 100 ether);
    }

    function testTokenInitializesWithCorrectData() public {
        assertEq(bokoToken.name(), "BokoToken");
        assertEq(bokoToken.symbol(), "BOKO");
        assertEq(bokoToken.decimals(), 18);
        assertEq(bokoToken.totalSupply(), 10000 ether);
    }

    function testAllowance() public {
        vm.prank(bob);
        bokoToken.approve(alice, 5 ether);
        assertEq(bokoToken.allowance(bob, alice), 5 ether);
    }

    function testTransferFrom() public {
        vm.prank(bob);
        bokoToken.approve(alice, 5 ether);
        vm.prank(alice);
        bokoToken.transferFrom(bob, alice, 5 ether);
        assertEq(bokoToken.balanceOf(bob), 95 ether);
        assertEq(bokoToken.balanceOf(alice), 5 ether);
    }

    function testMintFailsForNonOwner() public {
        vm.prank(bob);
        vm.expectRevert("Ownable: caller is not the owner");
        bokoToken.testMint(bob, 10 ether);
    }

    function testTransferInsufficientBalance() public {
        vm.prank(bob);
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        bokoToken.transfer(alice, 150000 ether);
    }

    function testTransferToZeroAddress() public {
        vm.prank(msg.sender);
        vm.expectRevert("ERC20: transfer to the zero address");
        bokoToken.transfer(address(0), 10 ether);
    }

    // function testTransferEvent() public {
    //     vm.startPrank(msg.sender);
    //     bokoToken.transfer(bob, 10 ether);
    //     vm.stopPrank();
    //     assertEq(
    //         vm.record().events[0].sig,
    //         keccak256("Transfer(address,address,uint256)")
    //     );
    //     assertEq(vm.record().events[0].args[0], address(this));
    //     assertEq(vm.record().events[0].args[1], bob);
    //     assertEq(vm.record().events[0].args[2], 10 ether);
    // }

    function testAllowanceUpdate() public {
        vm.prank(bob);
        bokoToken.approve(alice, 5 ether);
        uint256 firstAllowance = bokoToken.allowance(bob, alice);

        bokoToken.approve(alice, 10 ether);
        uint256 secondAllowance = bokoToken.allowance(bob, alice);

        assertEq(firstAllowance, 5 ether);
        assertEq(secondAllowance, 5 ether);
    }

    function testTransferFromInsufficientAllowance() public {
        vm.prank(bob);
        bokoToken.approve(alice, 2 ether);
        vm.prank(alice);
        vm.expectRevert("ERC20: insufficient allowance");
        bokoToken.transferFrom(bob, alice, 5 ether);
    }

    function testAllowanceReducedAfterTransferFrom() public {
        vm.prank(bob);
        bokoToken.approve(alice, 10 ether);
        vm.prank(alice);
        bokoToken.transferFrom(bob, alice, 5 ether);

        assertEq(bokoToken.allowance(bob, alice), 5 ether);
    }
}
