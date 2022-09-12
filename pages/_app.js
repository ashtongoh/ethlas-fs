import '../styles/globals.css'
import Layout from '../components/layout'
import React from 'react';
import { store } from '../store';
import { Provider } from 'react-redux'

import {
  WagmiConfig,
  createClient,
  defaultChains,
  configureChains,
  chain,
} from 'wagmi'

import {
  useQuery,
  useMutation,
  useQueryClient,
  QueryClient,
  QueryClientProvider,
} from '@tanstack/react-query'

import {alchemyProvider} from 'wagmi/providers/alchemy'
import { publicProvider } from 'wagmi/providers/public'
import { MetaMaskConnector } from 'wagmi/connectors/metaMask'
import { infuraProvider } from 'wagmi/providers/infura'

function MyApp({ Component, pageProps }) {

  // TanStack Query settings
  // Create a client
  const queryClient = new QueryClient()

  //Wagmi settings
  const { chains, provider, webSocketProvider } = configureChains(
    defaultChains,
    [infuraProvider({ apiKey: 'd8d884a3604f45e1b2273b6bd36127de' }),
    publicProvider(),
  ])

  const client = createClient({
    autoConnect: true,
    connectors: [
      new MetaMaskConnector({ chains }),
    ],
    provider,
    webSocketProvider,
  });

  return (
    <WagmiConfig client={client}>
      <Provider store={store}>
        <Layout>
          <QueryClientProvider client={queryClient}>
            <Component {...pageProps} />
          </QueryClientProvider>
        </Layout>
      </Provider>
    </WagmiConfig>
  );
}

export default MyApp
