import { useState } from 'react'
import "./index.css"
import relampago from './assets/Relampago.gif'
import radiator from './assets/Radiator.gif'
import Footer from './components/Footer.jsx'
import Aside from './components/Aside.jsx'
import Article from './components/Article.jsx'
import Header from './components/Header.jsx'

function App() {
  const dadosPost = {


    title: "Minha primeira Copa Pistão",
    date: "2026-04-14",
    preview: "A corrida foi desafiadora porem com os ensinamentos de Hudson Hornet eu consegui vencer",
    relampago: relampago,
    fig1: "Relampago mcquenn correndo na copa pistão",
    video: "https://www.youtube.com/watch?v=ez2TDPp8mwg",
    alt1: "Assista minha primeira corrida",
    
    criador:"Eduardo Rubel",
    ano:"2026",
    
    subtitulo: "Radiator Springs",
    fig2: "Radiator Springs é a cidade onde Relâmpago McQueen conhece seus amigos e aprende lições valiosas sobre amizade e humildade.",
    alt2: "Radiator Springs",
    radiator: radiator,

    titulo:"Meu Blog de Corridas",

    inicio:"inicio",
    corridas:"corridas",
    contato:"contato"
  }

  return (
    <div className="container">
      <Header titulo={dadosPost.titulo}/>
      <main>
      <Article
      titulo={dadosPost.titulo}
      title={dadosPost.title}
      date={dadosPost.date}
      preview={dadosPost.preview}
      relampago={dadosPost.relampago}
      texto={dadosPost.fig1}
      subtitulo={dadosPost.subtitulo}
      alt2={dadosPost.alt2}
      fig2={dadosPost.fig2}
      radiator={dadosPost.radiator}
      video={dadosPost.video}
      corridas={dadosPost.corridas}
      inicio={dadosPost.inicio}
      contato={dadosPost.contato}
      />
      </main>
      <Aside subtitulo={dadosPost.subtitulo} radiator={dadosPost.radiator} fig2={dadosPost.fig2} alt2={dadosPost.alt2}/>
      <Footer criador={dadosPost.criador} ano={dadosPost.ano}/>
    </div>
  )
}

export default App
