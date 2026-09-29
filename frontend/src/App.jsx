import { useEffect, useState } from 'react'

function App() {
  const [message, setMessage] = useState('Loading...')

  useEffect(() => {
    fetch(`${import.meta.env.VITE_API_BASE_URL}/`)
      .then((response) => response.json())
      .then((data) => setMessage(data.message))
  }, [])

  return (
    <div>
      <h1>Production App</h1>
      <p>{message}</p>
    </div>
  )
}

export default App