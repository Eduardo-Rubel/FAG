function Aside({subtitulo, radiator, fig2, alt2}) {
    return (
        <aside>
            <h3>{subtitulo}</h3>
            <figure>
                <img src={radiator} alt={alt2} /> 
                <figcaption>{fig2}</figcaption>
            </figure>
        </aside>
    )
}

export default Aside