// swap A token -> B token
function swap_token_to_token(address a,address b,uint256 amount) internal {
    a.approve(address(router), amount);
    address[] memory path = new address[](2);
    path[0] = address(a);
    path[1] = address(b);
    router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
        amount, 0, path, address(this), block.timestamp
    );
}