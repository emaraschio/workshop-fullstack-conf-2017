import React, { Component } from 'react'
import axios from 'axios'
import Note from './Note'
import NoteForm from './NoteForm'
import update from 'immutability-helper'
import Notification from './Notification'

class NotesContainer extends Component {
  constructor(props) {
    super(props)
    this.state = {
      notes: [],
      editingNoteId: null,
      notification: '',
      transitionIn: false
    }
  }

  componentDidMount = () => {
    axios.get(`${process.env.REACT_APP_API_URL}/api/v1/notes.json`)
    .then(response => {
      this.setState({notes: response.data})
    }).catch(error => console.log(error))
  }

  addNewNote = () => {
    axios.post(
      `${process.env.REACT_APP_API_URL}/api/v1/notes`,
      { note:
        {
          title: '',
          content: ''
        }
      }
    )
    .then(response => {
      const notes = update(this.state.notes, {
        $splice: [[0, 0, response.data]]
      })
      this.setState({
        notes: notes,
        editingNoteId: response.data.id
      })
    }).catch(error => console.log(error))
  }

  updateNote = (note) => {
    const noteIndex = this.state.notes.findIndex(x => x.id === note.id)
    const notes = update(this.state.notes, {
      [noteIndex]: { $set: note }
    })
    this.setState({notes: notes, notification: 'All changes saved', transitionIn: true})
  }

  deleteNote = (id) => {
    axios.delete(`${process.env.REACT_APP_API_URL}/api/v1/notes/${id}`)
    .then(response => {
      const noteIndex = this.state.notes.findIndex(x => x.id === id)
      const notes = update(this.state.notes, { $splice: [[noteIndex, 1]]})
      this.setState({notes: notes})
    })
    .catch(error => console.log(error))
  }

  resetNotification = () => {
    this.setState({notification: '', transitionIn: false})
  }

  enableEditing = (id) => {
    this.setState({editingNoteId: id}, () => { this.title.focus() })
  }

  render() {
    return (
      <div>
        <div>
          <button className="addNoteButton" onClick={this.addNewNote}>
            Add Note
          </button>
          <Notification in={this.state.transitionIn} notification={this.state.notification} />
        </div>
        {this.state.notes.map((note) => {
          if (this.state.editingNoteId === note.id) {
            return (<NoteForm note={note} key={note.id} updateNote={this.updateNote} titleRef={input => this.title = input} resetNotification={this.resetNotification} />)
          } else {
            return (<Note note={note} key={note.id} onClick={this.enableEditing} onDelete={this.deleteNote} />)
          }
        })}
      </div>
    );
  }

}

export default NotesContainer