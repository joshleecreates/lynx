import React, { useState } from 'react';

const SERVER_URL = 'http://localhost:8080';

export default function URIForm() {
  const initialValues = {
    uri: '',
  }

  const [errors, setErrors] = useState([]);
  const [submitted, setSubmitted] = useState(false);
  const [shortcuts, setShortcuts] = useState([]);
  const [values, setValues] = useState(initialValues);

  const callApi = async (uri: string) => {
    try {
      let response = await fetch(SERVER_URL + '/api/uris', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          'shortened_uri': {
            uri
          }
        }),
      })
      let responseBody = await response.json();
      if (response.status === 201) {
        resetForm()
        setShortcuts((shortcut) => ([...shortcuts, responseBody.data]))
      } else if (response.status === 422) {
        setErrors((errors) => ([...errors, 'Your URL format is invalid']))
      } else {
        setErrors((errors) => ([...errors, 'Server Error']))
      }
    } catch (error) {
      console.log(error)
    }
  }

  const ensureURIProtocol = (uri: string) => {
    return (uri.match(/^https?:\/\//))
      ? uri
      : 'http://' + uri
  }

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setSubmitted(true);
    await callApi(ensureURIProtocol(values.uri));
    setSubmitted(false);
  };

  const handleTextInputChange = (event: React.FormEvent<HTMLFormElement>) => {
    event.persist()
    setValues((values) => ({
      ...values,
      [event.target.getAttribute('name')]: event.target.value
    }))
  }

  const resetForm = () => {
    setValues(initialValues);
  }

  return (
    <div>
      <section className="section is-small">
        <div className="container">
          <h1 className="title">Lynx: The URL Shortener</h1>
          <h2 className="subtitle"><em>a wild cat with yellowish-brown fur (sometimes spotted), a short tail, and tufted ears, found chiefly in the northern latitudes of North America and Eurasia.</em></h2>
          {errors.map(error =>
            <div className="notification is-danger"><p>{error}</p></div>
          )}
          <form onSubmit={handleSubmit}>
            <div className="field">
              <label className="label">Enter a URL to shorten:</label>
            </div>
            <div className="field has-addons">
              <p className="control">
                <a className="button is-static is-large">
                  http://
                </a>
              </p>
              <div className="control">
                <input
                  className="input is-large"
                  name="uri"
                  type="text"
                  placeholder="www.joshuamlee.com"
                  value={values.uri}
                  onChange={handleTextInputChange}
                />
              </div>
              <div className="control">
                <input
                  type="submit"
                  value="Submit"
                  className="button is-info is-large"
                  disabled={submitted}
                />
              </div>
            </div>
          </form>
        </div>
      </section>
      <section className="section is-small">
        <h2 className="subtitle">Your shortcuts:</h2>
        <ul>
          {shortcuts.map(shortcut =>
            <li key={shortcut.id}>
              <a href={SERVER_URL + "/" + shortcut.slug}>
                {SERVER_URL + "/" + shortcut.slug} -> {shortcut.uri}
              </a>
            </li>
          )}
        </ul>
      </section>
    </div>
  );
}
