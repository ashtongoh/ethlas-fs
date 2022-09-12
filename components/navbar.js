import React, { useEffect }from 'react';

import {
    useEnsAvatar,
    useEnsName,
    useAccount,
    useConnect,
    useDisconnect,
} from 'wagmi'

const Navbar = () => {

    const [connectedAddress, setConnectedAddress] = React.useState(null);
    const { address, isConnected } = useAccount()
    const { connect, connectors, error, isLoading, pendingConnector } = useConnect()
    const { disconnect } = useDisconnect()

    useEffect(() => {
        if (isConnected && address) {
          setConnectedAddress(address)
        }
      }, [isConnected, address]);
    
      const handleDisconnect = () => {
        disconnect()
        setConnectedAddress(null)
      };

    return (
        <div className="navbar bg-secondary">
            <div className="flex-1">
                <a className="btn btn-ghost normal-case text-xl">🧋 B0BA3</a>
            </div>
            <div className="flex-auto">
                <div className="flex items-center space-x-2 ml-auto text-[#1E0536]">
                {connectors.map((connector) => (
              <button
              className="btn btn-primary"
                key={connector.id}
                onClick={() => connectedAddress ? handleDisconnect() : connect({connector})}
              >
                {/* {
                    isConnected ? (<></>) : (<>Connect {connector.name}</>)
                } */}
                {/* {connector.name ? (<>Connect Wallet</>) : (<></>)} */}
                {connector.name}
                {" "}
                {connectedAddress && (<>{connectedAddress.substring(0,6)}... (Disconnect)</>)}
                {/* {connectedAddress} */}
                {isLoading &&
                  connector.id === pendingConnector?.id &&
                  ' (connecting)'}
              </button>
            ))}
                </div>
            </div>
        </div>
    );
};
export default Navbar;