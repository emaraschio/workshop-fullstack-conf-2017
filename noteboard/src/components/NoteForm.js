import React, { Component } from 'react'
import axios from 'axios'

class NoteForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      title: this.props.note.title,
      content: this.props.note.content
    }
  }

  handleInput = (e) => {
    this.props.resetNotification()
    this.setState({[e.target.name]: e.target.value})
  }

  handleBlur = () => {
    const note = {
      title: this.state.title,
      content: this.state.content
    }

    axios.put(
      `http://localhost:3001/api/v1/notes/${this.props.note.id}`,
      {
        note: note
      })
    .then(response => {
      this.props.updateNote(response.data)
    }).catch(error => console.log(error))
  }

  render() {
    return (
      <div className="title">
        <form onBlur={this.handleBlur} >
          <input className='input' type="text"
            name="title" placeholder='Enter a Title'
            value={this.state.title} onChange={this.handleInput} 
            ref={this.props.titleRef} />
          <textarea className='input' name="content"
            placeholder='Add the content'
            defaultValue={this.state.content} onChange={this.handleInput} />
        </form>
      </div>
    );
  }
}

export default NoteForm