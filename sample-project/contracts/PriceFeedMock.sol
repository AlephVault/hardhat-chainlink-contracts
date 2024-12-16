// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract PriceFeedMock is AggregatorV3Interface {
    int256 public answer;
    uint8 private _decimals;
    uint256 private _version;
    string private _description;

    uint256 private blockTimestampDeduction = 0;

    constructor(int256 _answer, string memory _descr, uint8 _decs, uint256 _v) {
        answer = _answer;
        _description = _descr;
        _decimals = _decs;
        _version = _v;
    }

    function decimals() external view override returns (uint8) {
        return _decimals;
    }

    function description() external view override returns (string memory) {
        return _description;
    }

    function version() external view override returns (uint256) {
        return _version;
    }

    function getRoundData(
        uint80 /*_roundId*/
    )
    external
    view
    override
    returns (uint80 roundId, int256 ans, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (1, answer, getDeductedBlockTimestamp(), getDeductedBlockTimestamp(), 1);
    }

    function latestRoundData()
    external
    view
    override
    returns (uint80 roundId, int256 ans, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (1, answer, getDeductedBlockTimestamp(), getDeductedBlockTimestamp(), 1);
    }

    function getDeductedBlockTimestamp() internal view returns (uint256) {
        return block.timestamp - blockTimestampDeduction;
    }

    function setBlockTimestampDeduction(uint256 _blockTimestampDeduction) external {
        blockTimestampDeduction = _blockTimestampDeduction;
    }
}