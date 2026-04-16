import Navigation from './Navigation'

function Header({ titulo }) {
    return (
        <header>
            <h1>{titulo}</h1>
            <Navigation/>
        </header>
    )
}

export default Header