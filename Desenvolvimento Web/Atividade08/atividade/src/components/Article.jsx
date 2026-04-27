function Article({ title, date, preview, texto, relampago, alt1, video}) {
    return (
        <article>
            <h2>{title}</h2>
            <time>{date}</time>
            <p>{preview}</p>
            <figure>
                <img src={relampago} alt={alt1} />
                <figcaption>{texto}</figcaption>
                <a href={video} target="_blank" rel="noopener noreferrer"> Assista </a>
            </figure>
        </article>
    )
}

export default Article