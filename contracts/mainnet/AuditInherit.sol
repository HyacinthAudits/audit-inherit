pragma solidity ^0.8.0;

interface IDatabase {
    enum STATUS {
        NOTAUDITED,
        PENDING,
        PASSED,
        FAILED,
        REFUNDED
    }

    function beingAudited() external;

    function auditStatus(address contractAddress_) external view returns (STATUS status_);
}

/// @title   Audit Inherit
/// @notice  Contract that audited contracts will inherit form
/// @author  Hyacinth
abstract contract AuditInherit {
    /// MODIFIERS ///

    modifier auditPassed() {
        _auditedPassed();
        _;
    }

    /// ERRORS ///

    /// @notice Error for if the audit has not passed
    error AuditNotPassed();

    /// STATE VARIABLES ///

    /// @notice Address of database
    address public constant database = 0x879Cf19800308eC7ccc673B68cFeaF3c6c08CCc2;

    /// CONSTRUCTOR ///

    constructor() {
        IDatabase(database).beingAudited();
    }

    /// INTERNAL VIEW FUNCTION ///

    function _auditedPassed() internal view {
        IDatabase.STATUS status_ = IDatabase(database).auditStatus(address(this));
        if (status_ != IDatabase.STATUS.PASSED) revert AuditNotPassed();
    }
}
